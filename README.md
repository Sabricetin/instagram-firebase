# Firebase-Insta-Clone Uygulaması

Bu Swift kodları, Firebase-Insta-Clone uygulamasının çeşitli bölümlerini oluşturan bileşenlerdir. Uygulama, Firebase kullanarak kullanıcı kimlik doğrulama, veri saklama ve görüntüleme işlevlerini gerçekleştirir. Her bir kod bloğu, belirli bir işlevi yerine getirir ve birlikte çalışarak tam bir sosyal medya klonu oluşturur.

## 1. Giriş ve Kayıt Ekranı (ViewController.swift)

Bu kod, kullanıcıların Firebase kullanarak giriş yapmalarını ve yeni hesap oluşturmalarını sağlar.

### Özellikler

- **Arayüz Elemanları:**
  - `emailText`: Kullanıcının e-posta adresini girdiği metin alanı.
  - `passwordText`: Kullanıcının şifresini girdiği metin alanı.

### Kullanıcı Girişi

- `sigInClicked`: Kullanıcı giriş yapmak için bu butona tıkladığında, Firebase Authentication ile giriş yapılır. Hata durumunda uyarı gösterilir.

### Yeni Hesap Oluşturma

- `SignUpClicked`: Kullanıcı yeni hesap oluşturmak için bu butona tıkladığında, Firebase Authentication kullanılarak hesap oluşturulur. Hata durumunda uyarı gösterilir.

### Uyarı Mesajları

- `makeAlert`: Hata veya bilgi mesajları göstermek için kullanılır.

## 2. Ana Akış Ekranı (FeedViewController.swift)

Bu kod, kullanıcıların gönderilerini listeleyen bir tablo görünümü oluşturur.

### Özellikler

- **Veri Kaynakları:**
  - `userEmailArray`: Kullanıcıların e-posta adreslerini tutar.
  - `userCommentArray`: Kullanıcı yorumlarını tutar.
  - `likeArray`: Beğeni sayılarını tutar.
  - `userImageArray`: Kullanıcıların gönderi resim URL'lerini tutar.
  - `documentIDArray`: Belge ID'lerini tutar.

### Firebase'den Veri Çekme

- `getDataFromFirestore`: Firestore'dan verileri çeker ve tabloyu günceller.

### UITableViewDelegate ve UITableViewDataSource

- `tableView(_:numberOfRowsInSection:)`: Satır sayısını döner.
- `tableView(_:cellForRowAt:)`: Her bir hücreyi kullanıcı verileriyle doldurur.

## 3. Gönderi Hücresi (FeedCell.swift)

Bu kod, tablo görünümündeki her bir gönderi hücresini tanımlar.

### Özellikler

- **Arayüz Elemanları:**
  - `userEmailLabel`: Kullanıcı e-posta etiketini gösterir.
  - `commentLabel`: Kullanıcı yorum etiketini gösterir.
  - `likeLabel`: Beğeni sayısını gösterir.
  - `userImageView`: Kullanıcı gönderi resmini gösterir.
  - `documentIDLabel`: Belge ID'sini gösterir.

### Beğeni Fonksiyonu

- `likeButtonClicked`: Beğeni butonuna tıklandığında, ilgili gönderinin beğeni sayısını Firestore'da artırır.

## 4. Gönderi Yükleme Ekranı (UploadViewController.swift)

Bu kod, kullanıcıların yeni gönderi yüklemelerini sağlar.

### Özellikler

- **Arayüz Elemanları:**
  - `imageView`: Kullanıcının seçtiği görüntüyü gösterir.
  - `commentText`: Kullanıcının gönderi yorumu girdiği metin alanı.
  - `uploadClick`: Yükle butonu.

### Fotoğraf Seçme

- `chooseImage`: Kullanıcıya fotoğraf seçme imkanı sunar.
- `imagePickerController(_:didFinishPickingMediaWithInfo:)`: Seçilen fotoğrafı `imageView`'a atar.

### Fotoğraf ve Veriyi Firebase'e Kaydetme

- `saveClicked`: Seçilen fotoğrafı ve kullanıcı yorumunu Firebase Storage ve Firestore'a kaydeder.

## 5. Ayarlar Ekranı (SettingsViewController.swift)

Bu kod, kullanıcıların oturumlarını kapatmalarını sağlar.

### Oturum Kapatma

- `logoutcliked`: Kullanıcı çıkış yapma butonuna tıkladığında, Firebase'ten çıkış yapılır ve ana giriş ekranına yönlendirilir.
