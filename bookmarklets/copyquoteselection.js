// NAME: Copy Quote? :clipboard: 📋
// DESC: Copy quote as md with URL and title, including selection
// TODOs:
// add a cool icon
// selection url and or hash
// add a prompt to add a comment
// paste to notes.app
// Multi select with ...
// shorten with selection end
// BUG: Can't handle titles/elements

// normal
javascript: (function () {
    const title = document.title;
    const quote = window.getSelection().toString();
    const selection = window.getSelection();
    console.log('selection: ', selection);
    const range = selection.getRangeAt(0);
    console.log('range: ', range);
    const encodedRange = encodeURIComponent(range.toString());
    console.log('encodedRange: ', encodedRange);
    const linkToHighlight = location.href + '#:~:text=' + encodedRange;
    console.log('linkToHighlight: ', linkToHighlight);
    const citation = `> ${quote} -- [${title}](${linkToHighlight})`;
    console.log(citation);
    navigator.clipboard.writeText(citation);
})();

// just url
javascript: (function () {
    const encodedSelection = encodeURIComponent(selection);
    console.log('encodedSelection: ', encodedSelection);
    const linkToHighlight = location.href + '#:~:text=' + encodedSelection;
    console.log('linkToHighlight: ', linkToHighlight);
    navigator.clipboard.writeText(linkToHighlight);
})();

// unworking range method, replacing spaces with newlines for no apparent reason
// range seems like the right way to do things... but i'm not actually sure what it gets you
// maybe its easier to expand selection? and add prefixes? and suffixes? my issue with prefixes is that it sounds like
// they can handle multiple elements, which seems like a deal breaker, nvm looks like multi elements work in the extension
// its just 2k lines of code, vs 2
javascript: (function () {
    if (!'fragmentDirective' in document) {
        return alert('This page does not support fragmentDirective');
    }
    const title = document.title;
    const quote = window.getSelection().toString();
    const selection = window.getSelection();
    console.log('selection: ', selection);
    const range = selection.getRangeAt(0);
    console.log('range: ', range);
    const rangeString = range.toString();
    console.log('rangeString: ', rangeString);
    const encodedRange = encodeURIComponent(range.toString(rangeString));
    console.log('encodedRange: ', encodedRange);
    const linkToHighlight = location.href + '#:~:text=' + encodedRange;
    console.log('linkToHighlight: ', linkToHighlight);
    navigator.clipboard.writeText(linkToHighlight);
})();

// md style selection to block quote
javascript: (function () {
    function getDate() {
        const d = new Date();

        const year = d.getFullYear();
        const month = (d.getMonth() + 1).toString().padStart(2, '0');
        const day = d.getDate().toString().padStart(2, '0');

        return `${year}${month}${day}`;
    }

    function getSelectedText() {
        if (document.selection) {
            // For older versions of Internet Explorer
            return document.selection.createRange().text;
        } else if (window.getSelection) {
            // For modern browsers
            return window.getSelection().toString();
        } else if (document.getSelection) {
            // Fallback for other cases
            return document.getSelection();
        } else {
            // If no selection method is supported
            return '';
        }
    }

    const title = document.title;
    const quote = getSelectedText();
    const selection = window.getSelection();
    console.log('selection: ', selection);
    console.log('quote: ', quote);

    if (quote == '') {
        const citation = `[${title}](${location.href})  Accessed at ${getDate()}`;
        prompt('copy md formatted link', citation);
    }
    if (selection) {
        const range = selection.getRangeAt(0);
        console.log('range: ', range);
        const encodedRange = encodeURIComponent(range.toString());
        console.log('encodedRange: ', encodedRange);
        const linkToHighlight = location.href.replace(/:~:text=[^&]*/, '') + '#:~:text=' + encodedRange;
        console.log('linkToHighlight: ', linkToHighlight);
        const citation = `> ${quote} -- [${title}](${linkToHighlight})  Accessed at ${getDate()}`;

        prompt('copy md formatted blockquote', citation);
    }
})();
