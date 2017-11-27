map('q', 'E');
map('w', 'R');
settings.focusFirstCandidate = true;
settings.hintAlign = 'left';
settings.interceptedErrors = ['*'];
settings.omnibarSuggestionTimeout = 500;
settings.tabsThreshold = 0;
settings.theme = `
.expandRichHints, .collapseRichHints, .slideInBanner, .slideInRight, .slideOutRight {
    animation-duration: 0s;
}
#sk_status {
	right: 0%;
	border-radius: 0px 0px 0px 0px;
}
`;
