// Load URL Parameters if any --------------------------------------

const fieldName_BaseURL = 'web_page_url';
const fieldName_StartText = 'start_text';
const fieldName_EndText = 'end_text';

if (getUrlParam('p', '') != '') {
    document.getElementsByName(fieldName_BaseURL)[0].value = getUrlParam('p', '');
    if (decodeURIComponent(getUrlParam('s', '')) != '') {
        document.getElementsByName(fieldName_StartText)[0].value = decodeURIComponent(getUrlParam('s', ''));
        createChromeDeepLink();
    }
}

function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (m, key, value) {
        vars[key] = value;
    });
    return vars;
}

function getUrlParam(parameter, defaultvalue) {
    var urlparameter = defaultvalue;
    if (window.location.href.indexOf(parameter + '=') > -1) {
        urlparameter = getUrlVars()[parameter];
    }
    return urlparameter;
}

// Create URL code --------------------------------------

function createChromeDeepLink() {
    // Selecting the input element and get its value
    var BaseURL = document.getElementsByName(fieldName_BaseURL)[0];
    //Name must be unique b/c we take 1st one found
    var BaseURLval = BaseURL.value;
    if (BaseURLval == '') {
        alert('Please URL of web page to which to link.');
        BaseURL.focus();
    } else {
        var StartText = document.getElementsByName(fieldName_StartText)[0];
        //Name must be unique b/c we take 1st one found
        var StartTextval = StartText.value;
        if (StartTextval == '') {
            alert('Please enter some text within the web page to highlight.');
            StartText.focus();
        } else {
            var EndTextval = document.getElementsByName(fieldName_EndText)[0].value;
            //Name must be unique b/c we take 1st one found
            const URLparam = '#:~:text=';
            const sep = ',';

            // Calculate DeepLink
            var DeepLinkURL = BaseURLval + URLparam + encodeURIComponent(StartTextval);
            /* var DeepLinkURL = 'https://ghosh.com/t?u=' + escape(DeepLinkURLtemp); */
            if (EndTextval != '') DeepLinkURL = DeepLinkURL + sep + encodeURIComponent(EndTextval);
            var HTML = '<a href="' + DeepLinkURL + '" rel="noopener noreferrer" target="_noop">' + DeepLinkURL + '</a>';

            // Display result
            document.getElementById('DeepLinkURL').innerHTML = HTML;

            // Make Copy button visible
            var button = document.getElementById('buttonCopy');
            button.style.opacity = 1;
        }
    }
}

function copyDivToClipboard() {
    var range = document.createRange();
    range.selectNode(document.getElementById('DeepLinkURL'));
    window.getSelection().removeAllRanges();
    // clear current selection
    window.getSelection().addRange(range);
    // to select text
    document.execCommand('copy');
    window.getSelection().removeAllRanges();
    // to deselect
    alert('URL copied to clipboard');
}

/*
	function showExample() {
      	document.getElementsByName(fieldName_BaseURL)[0].value = "https://en.wikipedia.org/wiki/Wikipedia";
		document.getElementsByName(fieldName_StartText)[0].value = "Cultural impact";
		var button = document.getElementById('buttonCreate');
		button.focus();
	}
*/
