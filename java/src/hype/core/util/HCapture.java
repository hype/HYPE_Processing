package hype.core.util;

import processing.core.PApplet;
import processing.core.PGraphics;

public class HCapture {
	private PGraphics _capturer;
	private String _renderer;
	private String _filename;
	private boolean _isRecording;
	private int  _start,        _end;
//	private int  _startKeyCode, _endKeyCode;
//	private char _startKey,     _endKey;
	
	// TODO handle single frame recording
	
	public HCapture() {
		_start = _end = -1;
	}
	
	public HCapture capture() {
		_start = _end = H.app().frameCount;
		return this;
	}
	
	public HCapture capture(int frameNum) {
		_start = _end = H.app().frameCount;
		// SOMETHING SOMETHING
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
//		_startKeyCode = 0;
		_start = -1;
		return this;
	}
	
//	public HCapture startKey(int keyCode, char keyChar) {
//		_startKey = keyChar;
//		_startKeyCode = keyCode;
//		_start = -1;
//		return this;
//	}
	
	public int startKey() {
		return _startKey;
	}
	
//	public int startKeyCode() {
//		return _startKeyCode;
//	}
	
	public HCapture endKey(char keyChar) {
		_endKey = keyChar;
//		_endKeyCode = 0;
		_end = -1;
		return this;
	}
	
//	public HCapture endKey(int keyCode, char keyChar) {
//		_endKey = keyChar;
//		_endKeyCode = keyCode;
//		_end = -1;
//		return this;
//	}
	
	public int endKey() {
		return _endKey;
	}
	
//	public int endKeyCode() {
//		return _endKeyCode;
//	}
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
//				if(app.key )
//				_capturer = H.app().beginRecord(_renderer,_filename);
				//
			}
			if(!_isRecording) {
				//
			}
		} else {
			if(_start < 0) {
				// TODO
			} else {
				//
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
