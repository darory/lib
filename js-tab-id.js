function uuidv4() {
		return ([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g, c =>
			(c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
		);
	}
	var tabID = sessionStorage.tabID ? 
            sessionStorage.tabID : 
            sessionStorage.tabID = uuidv4();

UPDATE:
In some cases, you may have same sessionStorage in multiple tabs (e.g. when you duplicate tab). In that case, following code may help:

var tabID = sessionStorage.tabID && 
            sessionStorage.closedLastTab !== '2' ? 
            sessionStorage.tabID : 
            sessionStorage.tabID = Math.random();
sessionStorage.closedLastTab = '2';
$(window).on('unload beforeunload', function() {
      sessionStorage.closedLastTab = '1';
});
