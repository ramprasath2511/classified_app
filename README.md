# Flutter Technical Test

## Requirements
1. Add a button to the post details screen that navigates to a new screen showing a list of all comments on the post. Each item in the list should show the author and body of the comment.
2. Add a button to the post details screen that saves a post to be read offline. The state of the button should reflect whether the post is saved to read offline.
3. There should be a separate post list screen that displays only posts that are saved for offline reading. It should look and behave identically to the original post list screen.
4. The original post list and the offline post list screens should be embedded in a tabbed view. (You can use material widgets)
5. The tab item for the offline post list screen should be badged with the number of offline posts that have been saved.
6. Only details about the post have to be available to read offline. Post comments do not have to be available offline (but it's a bonus if they are).

## Implementation
- There are two screens used:
    - **Post List screen**: Fetches the list of live posts, where the "View Details" button navigates to the next screen (Post Details Screen), fetching that particular post with its comments (Title, Author, and the body).

    - **Post Details Screen**: Includes a "Save Offline" button which allows the post along with its comments to be saved offline and retrieved without internet whenever needed. The badge on the Post List screen reflects these saved posts.
    - In Addition a toggle(show comments/hide comments) button is added to show comments and hide comments

- The post list screen displays live and offline posts in separate tabs.

- When the internet is down, offline saved posts will still appear. Additionally, Users can delete saved posts from the Saved Feed.
- 
- When the internet is back, online enabled pull-to-refresh in the Live Feed to reload the posts.

- Both live and offline posts will look identical, with a "View Details" button to display each post's details.

- Implemented Translation & Theme Support.
