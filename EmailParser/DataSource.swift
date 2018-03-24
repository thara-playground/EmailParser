/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Cocoa

final class DataSource: NSObject {

  // MARK: Property

  @IBOutlet var textView: NSTextView!

  let hardwarePosts: [HardwarePost]
  
  // MARK: Initializer

  override init() {
    self.hardwarePosts = Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: "comp.sys.mac.hardware")?
      .flatMap({try? Data(contentsOf: $0)}).lazy
      .map(HardwarePost.init) ?? []
    super.init()
  }
}

extension DataSource: NSTableViewDataSource {

  func numberOfRows(in tableView: NSTableView) -> Int {
    return hardwarePosts.count
  }
}

extension DataSource: NSTableViewDelegate {

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    let cell = tableView.make(withIdentifier: tableColumn?.identifier ?? "", owner: self) as! PostCell
    cell.configure(hardwarePosts[row])
    return cell
  }

  func tableViewSelectionDidChange(_ notification: Notification) {
    guard let tableView = notification.object as? NSTableView else {
      return
    }
    textView.string = hardwarePosts[tableView.selectedRow].message
  }
}
