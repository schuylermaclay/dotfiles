// Just a bookmarklet to redirect medium.com articles to freedium.cfd, where said articles are free
// TODO add a cool icon
javascript: (function () {
    const currentUrl = window.location.href;
    if (currentUrl.indexOf('medium.com' > -1)) {
        let newUrl = `https://freedium.cfd/${currentUrl}`;
        window.location.href = newUrl;
    }
})();

javascript: (function () {
    window.location.href = `https://archive.ph/${window.location.href}`;
})();
