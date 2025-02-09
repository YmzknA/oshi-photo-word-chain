// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener("turbo:load", () => {
	const menuButton = document.querySelector('button.lg\\:hidden'); // Menuボタンを指定
	const menuDropdown = menuButton.querySelector('div.absolute'); // 対象のドロップダウンdiv

	if (menuButton && menuDropdown) {
		menuButton.addEventListener('click', () => {
			menuDropdown.classList.toggle('hidden');
		});
		document.addEventListener("click", (event) => {
			if (!menuButton.contains(event.target) && !menuDropdown.contains(event.target)) {
				menuDropdown.classList.add("hidden");
			}
		});
	}


});

