public static class HCapture {
	private PGraphics _capturer;
	private String _renderer;
	private String _filename;
	private boolean _isRecording;
	private int  _start,        _end;
	public HCapture() {
		_start = _end = -1;
	}
	public HCapture capture() {
		_start = _end = H.app().frameCount;
		return this;
	}
	public HCapture capture(int frameNum) {
		_start = _end = H.app().frameCount;
		return this;
	}
	public HCapture start(int frameNum) {
		_start = frameNum;
		return this;
	}
	public int start() {
		return _start;
	}
	public HCapture end(int frameNum) {
		_end = frameNum;
		return this;
	}
	public int end() {
		return _end;
	}
	/*
	public HCapture startKey(char keyChar) {
		_startKey = keyChar;
		_start = -1;
		return this;
	}
	public int startKey() {
		return _startKey;
	}
	public HCapture endKey(char keyChar) {
		_endKey = keyChar;
		_end = -1;
		return this;
	}
	public int endKey() {
		return _endKey;
	}
	*/
	public boolean isRecording() {
		return _isRecording;
	}
	public HCapture filename(String s) {
		_filename = s;
		return this;
	}
	public String filename() {
		return _filename;
	}
	public HCapture renderer(String s) {
		_renderer = s;
		return this;
	}
	public String renderer() {
		return _renderer;
	}
	public void run() {
		if(_isRecording) {
			if(_end < 0) {
				if(H.app().frameCount >= _end) _isRecording = false;
			} else {
				PApplet app = H.app();
			}
			if(!_isRecording) {
			}
		} else {
			if(_start < 0) {
			} else {
			}
			if(_isRecording) {
				H.app().endRecord();
				if(_capturer != null) {
					_capturer.save(_filename);
					_capturer = null;
				}
			}
		}
	}
}
