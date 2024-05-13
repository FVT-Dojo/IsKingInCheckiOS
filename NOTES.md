#  IsKingInCheck goes iOS

- ✅ Create a button on the main screen
- ✅ Create a first test, to verify the existence of the button
- ✅ Create a chessboard component
    - Currently the chessboard is all black. Let's see if we can get it to show some color
- ✅ REFACTOR: Update the chessboard to make it possible to display pieces and set the color of a square
- ✅ Show the K and R using a mock
- ✅ REFACTOR: Remove the enum of pieces to simplify the code, and to enable the backend to invent new pieces on the fly
- ✅ REFACTOR: Move parts in the chessboard file to their own files, to adhere to MVVM and clean up the code
- ✅ Implement the actual API call!
- ✅ Show a label according to the API whether the king is in check or not.
    - ✅ Have 2 previews: one in check, one not in check
    - ✅ Implement the label
    
- ✅ Implement the start button, so it shows the chessboard after pushing the button
- ✅ Refresh the chessboard when navigating back and forward

- See what we can test
- ✅ UI Test: Click the button, verify that it navigates to the chessboard
    - Check that the right content is shown according to the mocked API Client
