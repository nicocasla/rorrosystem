<!DOCTYPE html>
<html>
<body>
	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	<script>
     var selectedSong;
    //
      // 2. This code loads the IFrame Player API code asynchronously.
      var tag = document.createElement('script');

      tag.src = "http://www.youtube.com/iframe_api";
      var firstScriptTag = document.getElementsByTagName('script')[0];
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

      // 3. This function creates an <iframe> (and YouTube player)
      //    after the API code downloads.
      var player;
      function onYouTubeIframeAPIReady() {
        player = new YT.Player('player', {
          height: '390',
          width: '640',
          events: {
            'onStateChange': onPlayerStateChange
          }
        });
      }
//    videoId: 'rYEDA3JcQqw',   'onReady': onPlayerReady,
      // 4. The API will call this function when the video player is ready.
      function onPlayerReady(event) {
        event.target.playVideo();
      }

      // 5. The API calls this function when the player's state changes.
      //    The function indicates that when playing a video (state=1),
      //    the player should play for six seconds and then stop.
      var done = false;
      function onPlayerStateChange(event) {
        if (event.data == YT.PlayerState.ENDED){
        	nextListSong();
        }
      }
      
      function replace(str){
    	  return str.replace("?","/").replace("=","/").replace("watch/","");
      }
      
      function addSong(){
      	var songName = replace(document.getElementById("songName").value);
      	$.get( "http://10.221.20.18:8080/VideoPlayer/songManager?operation=addSong&songName=" + songName,
      		function( data ) {
	    	  	refreshSongs();
	      }
      	);
      	document.getElementById("songName").value = "";
      }
     
      function refreshSongs(){
    	  $.get( "http://10.221.20.18:8080/VideoPlayer/songManager?operation=getSongs",
          		function( data ) {
		    		  var res = data.replace("[","").replace("]","").split(",");
		    		  $('#selectSongs').find('option').remove();
		    		  $.each(res, function(key, value) {   
		    			     $('#selectSongs')
		    			         .append($("<option></option>")
		    			         .attr("value",key)
		    			         .text(value)); 
		    			});
      	});
      }
      function nextListSong(){
    	  var select = document.getElementById("selectSongs");
    	  select.options[selectedSong + 1].setAttribute("selected", "selected");
    	  changeListSelectedSong();
      }
      
      function changeListSelectedSong(){
    	  var select = document.getElementById("selectSongs");
    	  selectedSong = select.selectedIndex;
    	  player.loadVideoByUrl(select.options[select.selectedIndex].text,0,"medium")
      }
      
      function removeSong(){
    	  
    	  var songName = $.trim($("#selectSongs option:selected" ).text());
        	$.get( "http://10.221.20.18:8080/VideoPlayer/songManager?operation=removeSong&songName=" + songName,
        		function( data ) {
  	    	  	refreshSongs();
  	     		 }
        	);
      }
      function waitRefresh(){
    	  setTimeout(
        		  function() 
        		  {
        			  refreshSongs();waitRefresh();
        		  }, 5000);
      }
      $(document).ready(  waitRefresh());
    
		
    </script>
	<!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
	
	<h1>Rorro System </h1>
	<div id="player"></div>

	<select size="10" id="selectSongs"
		ondblclick='changeListSelectedSong()'>
	</select>

	<input type="text" id="songName">
	<input type="button" value="agregar" onclick='addSong()'>
	<input type="button" value="remover" onclick='removeSong()'>


</body>
</html>