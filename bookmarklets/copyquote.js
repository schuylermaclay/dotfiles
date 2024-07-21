// NAME: Copy Quote? :clipboard: 📋
// DESC: Copy quote as md with URL and title
// TODOs:
// add a cool icon
// selection url and or hash
// add a prompt to add a comment
// paste to notes.app
// Multi select with ...

javascript: (function () {
    const title = document.title;
    const quote = window.getSelection().toString();
    const url = window.location.href;
    const citation = `> ${quote} -- [${title}](${url})`;
    console.log(citation);
    navigator.clipboard.writeText(citation);
})();

// selection as link name
javascript: (function () {
    const quote = window.getSelection().toString();
    const url = window.location.href;
    let html = `
    <a href="${url}">${quote}</a>
    `;
    console.log(html);
    const clipboardItem = new ClipboardItem({
        'text/html': new Blob([html], { type: 'text/html' }),
        'text/plain': new Blob([html], { type: 'text/plain' }),
    });

    navigator.clipboard.write([clipboardItem]).then(
        (_) => console.log('clipboard.write() Ok'),
        (error) => alert(error)
    );
})();
