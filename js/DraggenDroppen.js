window.DraggenDroppen = (function() {

	var flashEl;
	var isOver = false;
	var files = [];

	const delay = 1;
	const chunkSize = 32768;

	function handleDragOver(event) {
		event.dataTransfer.dropEffect = 'copy';
		event.preventDefault();
		event.stopPropagation();
		if(!isOver) {
			isOver = true;
			flashEl.DraggenDroppen_dragOver();
		}
	}

	function handleDragLeave(event) {
		event.dataTransfer.dropEffect = 'none';
		event.preventDefault();
		event.stopPropagation();
		if(isOver) {
			isOver = false;
			flashEl.DraggenDroppen_dragLeave();
		}
	}

	function handleDrop(event) {
		event.preventDefault();
		event.stopPropagation();
		var fileCount = event.dataTransfer.files.length;
		var filesLeft = fileCount;
		if(fileCount > 0) {
			files = [];
			removeListeners();
			for(var i = 0; i < fileCount; i++) {
				var file = event.dataTransfer.files[i];
				var reader = new FileReader();
				reader.onload = (function(f) {
					return function(e) {
						files.push({
							name: f.name,
							type: f.type,
							content: e.target.result
						});
						if(--filesLeft == 0) {
							sendFiles();
						}
					};
				})(file);
				reader.onerror = (function(f) {
					return function(e) {
						if(--filesLeft == 0) {
							sendFiles();
						}
					};
				})(file);
				reader.readAsBinaryString(file);
			}
		}
		isOver = false;
	}

	function sendFiles() {
		console.log(files.length);
		if(files.length > 0) {
			sendFileChunk(files.shift());
		} else {
			addListeners();
		}
	}

	function sendFileChunk(file, index) {
		var j, k;
		var a = [];
		var content = file.content;
		var len = content.length;
		if(typeof index == "undefined") {
			flashEl.DraggenDroppen_begin(file.name, file.type, len);
			index = 0;
		} else if(index == len) {
			flashEl.DraggenDroppen_end();
			setTimeout(sendFiles, delay);
			return;
		} else {
			for(j = 0; index < len && j < chunkSize; j++, index++) {
				a.push(content.charCodeAt(index).toString(16));
			}
			flashEl.DraggenDroppen_chunk(a.join(","));
		}
		setTimeout(sendFileChunk, delay, file, index);
	}

	function addListeners() {
		flashEl.addEventListener('dragover', handleDragOver, false);
		flashEl.addEventListener('dragleave', handleDragLeave, false);
		flashEl.addEventListener('drop', handleDrop, false);
	}

	function removeListeners() {
		flashEl.removeEventListener('dragover', handleDragOver, false);
		flashEl.removeEventListener('dragleave', handleDragLeave, false);
		flashEl.removeEventListener('drop', handleDrop, false);
	}

	return {
		init: function(flashElement) {
			if(flashEl = flashElement) {
				this.enable = function() {
					var hasFileReader = (typeof FileReader !== "undefined");
					if(hasFileReader) { addListeners(); }
					flashEl.DraggenDroppen_capability(hasFileReader);
				}
			}
		}
	};

})();
