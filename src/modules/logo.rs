use leptos::prelude::*;

#[component]
pub fn Logo() -> impl IntoView {
    view! {
        <a href = "/">
            <div id="logo" class="logo">
                <img src="/logo.svg" />
            </div>
        </a>
    }
}
