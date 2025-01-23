use leptos::prelude::*;

#[component]
pub fn TextIn() -> impl IntoView {
    view! {
        <div class="typing">
            <button>
                <i class="fa-solid fa-plus"/>
            </button>

            <input type="text" placeholder="Discover something" value="" />

            <button>
                <i class="fa-solid fa-microphone"/>
            </button>
            <button>
                <i class="fa-solid fa-circle-up"/>
            </button>
        </div>
    }
}
