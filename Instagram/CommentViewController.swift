//
//  CommentViewController.swift
//  Instagram
//
//  Created by Koji Kida on 2020/04/11.
//  Copyright © 2020 Koji Kida. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    @IBOutlet weak var commentTextView: UITextView!
    
    //ホーム画面からpostDataを受け取るための変数を設定
    var postDT: PostData?
    
    override func viewDidLoad() {
           super.viewDidLoad()
    
    }
//コメントの投稿======================================

    //投稿ボタンが押された時のアクション。ここにFirestoreを更新させるためのコードを書く
    @IBAction func commentButton(_ sender: Any) {
        print("DEBUG_PRINT: 投稿ボタンが押されました。")
        
        // TextViewからデータを取り出す
        let commentData = commentTextView.text!
        //print("DEBUG_PRINT: \(commentData) ")
        //コメントが入力されていない時はHUDを出して何もしない
            if commentData.isEmpty {
                SVProgressHUD.showError(withStatus: "コメントを入力して下さい")
                return
        }

        
        //表示名を取得
         let name = Auth.auth().currentUser?.displayName
        
        //配列の要素に追加する
        var updateValue: FieldValue
        updateValue = FieldValue.arrayUnion([name! + " : " + commentData])
        
        
        
        
        // commentsに更新データを書き込む
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postDT!.id)
        postRef.updateData(["comments": updateValue])
        
        //コメント投稿完了
        SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました")
        
        //ホーム画面に戻る。
        self.dismiss(animated: true, completion: nil)
        }
    
    //}
    
    @IBAction func cancelButton(_ sender: Any) {
        //ホーム画面に戻る
        self.dismiss(animated: true, completion: nil)
        print("DEBUG_PRINT: キャンセルされました")
    }
    
   

        // Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
