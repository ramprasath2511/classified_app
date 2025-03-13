# technicaltest_flutter

A new Flutter project.

## Getting Started

#Fetched API data:
Retrieved post data from an API.
Fetched post details from the API.
Implemented a comments section that fetches comments along with the author's name. The comments section is toggled using a "Show Comments" button, which switches back to "Hide Comments" when clicked.

#Offline storage:
Added a button in the post details page (top left) to save posts for offline viewing.
Used Shared Preferences for local storage, as it is widely supported across browsers and apps.
Stored post details and comments locally.

#Home Page Tabs:
Implemented a tab controller with two sections: Live Feed and Saved Feed.
Saved posts are also tagged and displayed in the live feed.
Users can delete saved posts from the Saved Feed.

#Network handling & API calls:
Managed API calls based on the device's network status.
Displayed a Snackbar message ("No Internet") if offline.
Enabled pull-to-refresh in the Live Feed to reload posts. If offline, users can pull down to refresh once back online.

#Testing:
Performed unit testing, and all tests passed successfully.
Conducted widget testing for the first page.

#Additional Features:
#Translation & Theme Support:
Added language translation (English ↔ Spanish) via the app drawer.
Language preference is stored locally, ensuring it persists after the app is restarted.
#State Management:
Used Provider for state management.
#Navigation:
Implemented routing for smooth navigation.
#Organized Codebase:
Used a model-based approach for API responses.

