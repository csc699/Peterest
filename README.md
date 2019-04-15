Unit 8: Group Milestone
===

# Peterest

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
1. [Schema](#Schema)

## Overview
### Description
Posting photos of an individual's pets and share them with others. Could be used to meet new friends with love for animals.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Share Pet Photos / Social Networking
- **Mobile:** This app would be primarily developed for mobile.
- **Story:** Analyzes user profile, and connects them to other users with similar profile information. The user can then befriend them if wanted.
- **Market:** Any individual could choose to use this app, and are Pet lovers and owners.
- **Habit:** This app could be used as often or unoften as the user wanted depending on how much they want to share.
- **Scope:** First we would start with pairing people based on similar pet interests, then perhaps evolve into a social media application similar to Facebook. Large potential to use with Pinterest.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] [Sign up, login] 
- [ ][Main page with posts]
- [ ][Click on a picture to see comments]
- [ ][Submit a comment]
- [ ][Profile page, user can edit name, password, and email information] 
- [ ][Friend list] 
- [ ][Search for friend to add]


**Optional Nice-to-have Stories**

* [message a friend]
* [pin posts (paw print)]
* [like posts + counter]
* [post videos]
* [show user posts in profile]
* [settings]

### 2. Screen Archetypes

* Login
* Register - User signs up or logs into their account
  * Upon downloading of the application, the user is prompted to sign up or log in to gain access.
  * Upon reopening of the application, the user stays logged in.
* Profile Screen
  * Allows user to upload a photo and fill/edit in information.
* Post Screen
  * Allows user to view photos that other users have upload.
  * Allows user to see comment when photo is click and add comment.
* Friend Screen
  * Allows user to add friends and view their profile.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Post Screen
* Profile
* Friends

Optional:
* Message
* Video
* Settings

**Flow Navigation** (Screen to Screen)

* Forced Log-in -> Account creation if no log in is available
* Posts View -> Jumps to detail view of photo and comments once the post is clicked
* Profile -> Text field to modifiy
* Friends -> Search for friends or view friend profile

## Wireframes
<img src="http://i67.tinypic.com/52gy6r.jpg" width=600 />

### [BONUS] Digital Wireframes & Mockups
<img src="https://i.imgur.com/ZYfZZr9.png" width=600>
<img src="https://i.imgur.com/QYaixZU.png" width=600>
<img src="https://i.imgur.com/m2QqyPk.png" width=600>
<img src="https://i.imgur.com/HXfUOLJ.png" width=600>

### [BONUS] Interactive Prototype
<img src='http://g.recordit.co/dqSu5Vuuei.gif' title='Video Walkthrough' width=300 alt='Video Walkthrough' />

## Schema

### Models

**Post**

| Property | Type | Description |
| --- | --- | --- |
| objectId | String | unique id for the user post (default field) |
| author | Pointer to User | image author |
| image | File | image that user posts |
| caption | String | image caption by author |

**Profile**

| Property | Type | Description |
| --- | --- | --- |
| objectId | String | unique id for the user |
| author | Pointer to User | user profile name |
| image | File | user profile image |

**Friends**

| Property | Type | Description |
| --- | --- | --- |
| objectId | String | unique id for the user |

### Networking

**Network request Action**

| CRUD | HTTP Verb | Example |
| --- | --- | --- |
| Create | POST | Creating a new post |
| Read | GET | Fetching posts for a user's feed |
| Update | PUT | Changing a user's profile image |
| Delete | DELETE | Deleting a comment |

**Network Request Outline**

* Home Feed Screen
	* (Read/GET) Query all posts recently updated
	* (Delete) Delete existing like
	* (Create/POST) Create a new comment on a post
	* (Delete) Delete existing comment
* Create Post Screen
	* (Create/POST) Create a new post object
* Profile Screen
	* (Read/GET) Query logged in user object
	* (Update/PUT) Update user profile image
* Friend Search Screen
	* (Read/GET) Query all user by name search

**Parse Networking Methods**

| Parse Method                           | Example                          |
| --- | --- |
| Create and save objects                | Creating a new post              |
| Query objects and set conditions       | Fetching posts for a user's feed |
| Query object, update properties & save | Changing a user's profile image  |
| Query object and delete                | Deleting a comment               |

**Parse Query Code Snippet**
```swift
// iOS
// (Read/GET) Query all posts recently updated
let query = PFQuery(className: "Post")
query.includeKey(["author"])
query.limit = 20
query.findObjectsInBackground { (posts, error) in
    if posts != nil {
    	self.posts = posts!
    	self.tableView.reloadData()
    }
}
```
**Updated Gif of Work in Progress**

<img src='http://g.recordit.co/BhRmxzX5kI.gif' title='Video Walkthrough' width=300 alt='Video Walkthrough' />
