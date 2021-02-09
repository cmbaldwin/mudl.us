import Shuffle from 'shufflejs';

document.addEventListener("turbolinks:load", function() {
	const shuffleInstance = new Shuffle(document.getElementById('grid'), {
		itemSelector: '.shuffle-brick',
		sizer: '.shuffle-sizer'
	});
})
