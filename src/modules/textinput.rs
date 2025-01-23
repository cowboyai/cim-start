use leptos::prelude::*;

#[component]
pub fn TextIn() -> impl IntoView {
    view! {
        <div class="typing">
            <input type="text" placeholder="Discover something" value="" />
            <button>
                <i class="fa-solid fa-circle-up"/>
            </button>
        </div>
    }
}
