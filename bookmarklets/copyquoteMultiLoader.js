// NAME: Copy Quote? :clipboard: 📋
javascript: (function () {
    const title = document.title;
    const quote = window.getSelection().toString();
    const url = window.location.href;
    navigator.clipboard.writeText(title);
    navigator.clipboard.writeText(quote);
    navigator.clipboard.writeText(url);
})();
