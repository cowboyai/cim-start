use leptos::prelude::*;

#[component]
pub fn History(children: Children) -> impl IntoView {
    view! {
        <div class="history">
            {children()}
        </div>
    }
}
