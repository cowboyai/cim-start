use crate::modules::hamburger::HamburgerMenu;
use crate::modules::logo::Logo;
use crate::modules::masthead::Masthead;
use leptos::prelude::*;

#[component]
pub fn Header() -> impl IntoView {
    view! {
        <header>
            <Logo/>
            <Masthead/>
            <HamburgerMenu>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-question"></i>
                        "help"
                    </a>
                </li>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-rocket"></i>
                        "about"
                    </a>
                </li>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-envelope"></i>
                        "contact"
                    </a>
                </li>
            </HamburgerMenu>
        </header>
    }
}
