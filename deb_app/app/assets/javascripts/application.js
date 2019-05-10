// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require rails-ujs
//= require turbolinks
//= require_tree .


window.onload = function(){

   var myAudio = document.getElementById('my-audio');
   var play = document.getElementById('play');
   var pause = document.getElementById('pause');
   var loading = document.getElementById('loading');
   var bar = document.getElementById('bar');
   var bar2 = document.getElementById('bar2');
   var song_playing = 0; 
   
   // Buffering and seekable

   function displayControls() {
      loading.style.display = "none";
      play.style.display = "block";
   }
   $(document).on('turbolinks:load', function() {
      document.location.reload(); 
   });
   // check that the media is ready before displaying the controls
   if (myAudio.paused) {
      displayControls();
   } else {
      // not ready yet - wait for canplay event
      myAudio.addEventListener('canplay', function() {
         displayControls();
      });
   }
  
    
   play.addEventListener('click', function() {
      document.getElementById("song" + song_playing).style.backgroundColor = "white"
      myAudio.play();
      play.style.display = "none";
      pause.style.display = "block";
   });
    
   pause.addEventListener('click', function() {
      myAudio.pause();
      pause.style.display = "none";
      play.style.display = "block";
   });
    
   // display progress
    
   myAudio.addEventListener('timeupdate', function() {
      //sets the percentage
      bar.style.width = parseInt(((myAudio.currentTime / myAudio.duration) * 100), 10) + "%";
      var barWidth = parseInt(((myAudio.currentTime / myAudio.duration) * 100), 10);
      var myBufferedTimeRanges = myAudio.buffered;
      // var mySeekableTimeRanges = myAudio.seekable;
      bar2.style.width = parseInt( (myAudio.buffered.end(0) - myAudio.currentTime)/myAudio.duration * 100, 10) + "%";
   });
   
   var progress = document.getElementById('progress');

  progress.addEventListener('click', function(e) {
      
  // calculate the normalized position clicked
  var clickPosition = (e.pageX  - this.offsetLeft) / this.offsetWidth;
  var clickTime = clickPosition * myAudio.duration;

  // move the playhead to the correct position
  myAudio.currentTime = clickTime;
  
  });
  
 myAudio.addEventListener("ended",function() {
       document.getElementById("song" + song_playing).style.backgroundColor = "";
       myAudio.pause();
       play.style.display = "none";
       pause.style.display = "block";
       this.currentTime = 0;
       song_playing += 1;
       song_playing = song_playing%5;
       var next_song = "assets/" + document.getElementById("song" + song_playing).getAttribute('data-value');
       this.src = next_song;
       document.getElementById("song" + song_playing).style.backgroundColor = "white";
       this.play();
 }); 
 
   

    var songs = document.getElementById("audio_ul" );
    songs.addEventListener('click', function() { 
         document.getElementById("song" + song_playing).style.backgroundColor = "";
         song_playing = parseInt(event.target.getAttribute('data-value'), 10) - 1;
         myAudio.src = "assets/" + document.getElementById("song" + song_playing).getAttribute('data-value');
         document.getElementById("song" + song_playing).style.backgroundColor = "white";
         play.style.display = "none";
         pause.style.display = "block";
         myAudio.play();
    });
   
};
