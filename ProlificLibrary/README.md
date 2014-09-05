ProlificLibrary
===============

A book tracking app in Objective-C by Albert Lardizabal for Prolific Interactive


###Implementation Highlights:


* AFNetworking is used for all API requests
* NSOperationQueue used to manage background and main thread processes

* DataStorage class created as a singleton to store the array of books

* IB Autolayout used

* UIAlertView delegate methods implemented to determine the correct course of action based on the user's response

* Books in the table view are sorted alphabetically in ascending order by title
* Swipe to delete method implemented in table view (delegate method)
* Pull down to refresh table view implemented using UIRefreshControl

* Sharing book details via Facebook, Twitter, Messages, and Email available on a valid test device

* Animation of views implemented to keep text fields visible during keyboard input
* Views are moved up to make room for the keyboard while preserving visibility of the text fields
* Notification center used to detect visibility of keyboard

* For screens with text fields - Pressing the return key or tapping outside the text fields will hide the keyboard
* Autocapitalization implemented (UITextAutocapitalizationTypeWords)



###Things I wanted to implement:

1. A search function within the table view
2. An alphabetically indexed table view similar to the iPhone Contacts app
3. Editing mode for the table view that would allow quick deletion of a large number of items


##Addendum:

###Overview of Classes

* **AALAPIClient** - Uses AFNetworking to make API requests
* **AALLibraryDataStore** - Used to create the data store singleton and kick off requests to the AALAPIClient class
* **AALConstants** - Central location for constants.  Not used much for this project.

* **AALMainBooksTableViewController** - Table view controller class.  The VC is the main screen that lists all available books.
* **AALBookDetailViewController** - The class that lists the full detail for a book selected from the table view
* **AALCheckoutViewController** - Manages the book checkout process
* **AALEditBookViewController** - Allows editing of a book's details
* **AALAddBookViewController** - This class manages the creation of a new entry in the library

* **AALBook** - Custom class that describes the object model of a book retrieved from the API


Enjoy!  Let me know if you have any questions.

Albert