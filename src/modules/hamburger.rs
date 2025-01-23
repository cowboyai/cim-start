use leptos::prelude::*;

#[component]
pub fn HamburgerMenu(children: Children) -> impl IntoView {
    view! {
        <div class="menu hamburger">
            <div class="icon"><i class="fa-solid fa-bars"/></div>
            <nav>
                <ul>
                    {children()}
                </ul>
            </nav>
        </div>
    }
}
