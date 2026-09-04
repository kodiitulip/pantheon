//@ts-check

// NAME: TunaOBS provider
// AUTHOR: kodiitulip
// DESCRIPTION: Send song information to TunaOBS via the web server

/**
 * @typedef {Object} MusicData
 * @property {string|null|undefined} album
 * @property {string} album_url
 * @property {string[]} artists
 * @property {string} cover
 * @property {string} cover_url
 * @property {number} duration
 * @property {number} progress
 * @property {"stopped"|"playing"|"unknown"} status
 * @property {string} title
 * @property {string} alternativeTitle
 * @property {string} url
 * @property {string[]} tags
 */

/// <reference path="../../../../spicetify-cli/globals.d.ts" />
(function tunaOBSProvider() {
  // Wait for Spicetify to be ready
  if (!Spicetify.Player || !Spicetify.Platform) {
    setTimeout(tunaOBSProvider, 100);
    return;
  }

  /** @returns {MusicData} */
  const getMusicData = () => {
    const track = Spicetify.Player.data.item;
    return {
      album: track.album.name,
      album_url: Spicetify.URI.fromString(track.album.uri).toURL(),
      artists: track.artists?.map(({ name }) => name) ?? [],
      cover: "https://i.scdn.co" + Spicetify.URI.fromString(track.metadata.image_url).toURLPath(true),
      cover_url: "https://i.scdn.co" + Spicetify.URI.fromString(track.metadata.image_url).toURLPath(true),
      duration: Spicetify.Player.getDuration(),
      progress: Spicetify.Player.getProgress(),
      status: Spicetify.Player.isPlaying() ? "playing" : "stopped",
      title: track.name,
      alternativeTitle: track.name,
      url: Spicetify.URI.fromString(track.uri).toURL(),
      tags: [],
    };
  };

  /** @param {MusicData} data */
  const post = (data) => {
    const port = 1608;
    const headers = {
      "Content-Type": "application/json",
      Accept: "application/json",
    };
    const url = `http://127.0.0.1:${port}/`;
    fetch(url, {
      method: "POST",
      headers,
      body: JSON.stringify({ data }),
    })
      .then(() => {
        console.debug(`obs-tuna webserver at port ${port} is accessible.`);
      })
      .catch((error) => {
        console.debug(`Error: '${error.code || error.errno}'`);
      });
  };

  const player = Spicetify.Player;
  const callback = () => post(getMusicData());
  player.addEventListener("songchange", callback);
  player.addEventListener("onplaypause", callback);
  player.addEventListener("onprogress", callback);
  callback();
})();
