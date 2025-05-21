```php
public function action_save()
{
    // Get post_id nếu là edit
    $post_id = (int) Input::post('post_id', 0);

    // TODO: Save vào bảng posts (bỏ qua ở đây)
    if ($post_id == 0) {
        // Giả lập insert post
        DB::insert('posts')->set(['title' => 'Demo', 'created_at' => DB::expr('NOW()')])->execute();
        $post_id = DB::last_insert_id();
    }

    // --- Xử lý Time Schedule ---
    $schedules = Input::post('schedules', []);
    foreach ($schedules as $index => $schedule) {
        $time_hh = $schedule['time_hh'] ?? '';
        $time_mm = $schedule['time_mm'] ?? '';
        $job_title = $schedule['job_title'] ?? '';
        $job_content = $schedule['job_content'] ?? '';
        $editor_comment = $schedule['editor_comment'] ?? '';

        // Xử lý ảnh
        $main_image = $this->handle_upload('schedules', $index, 'main_image');
        $sub_image_1 = $this->handle_upload('schedules', $index, 'sub_image_1');
        $sub_image_2 = $this->handle_upload('schedules', $index, 'sub_image_2');

        // Lưu DB
        DB::insert('time_schedules')->set([
            'post_id' => $post_id,
            'sort_order' => $index,
            'time_hh' => $time_hh,
            'time_mm' => $time_mm,
            'job_title' => $job_title,
            'job_content' => $job_content,
            'main_image' => $main_image,
            'sub_image_1' => $sub_image_1,
            'sub_image_2' => $sub_image_2,
            'editor_comment' => $editor_comment,
            'created_at' => DB::expr('NOW()'),
            'updated_at' => DB::expr('NOW()'),
        ])->execute();
    }

    // --- Xử lý Attractive Points ---
    $points = Input::post('points', []);
    foreach ($points as $index => $point) {
        $title = $point['title'] ?? '';
        $details = $point['details'] ?? '';
        $image = $this->handle_upload('points', $index, 'image');

        DB::insert('attractive_points')->set([
            'post_id' => $post_id,
            'sort_order' => $index,
            'title' => $title,
            'details' => $details,
            'image' => $image,
            'created_at' => DB::expr('NOW()'),
            'updated_at' => DB::expr('NOW()'),
        ])->execute();
    }

    Session::set_flash('success', 'Post saved successfully');
    Response::redirect('/admin/post');
}
```

```php
private function handle_upload($group, $index, $field)
{
    if (
        isset($_FILES[$group]['name'][$index][$field]) &&
        is_uploaded_file($_FILES[$group]['tmp_name'][$index][$field])
    ) {
        $file_name = $_FILES[$group]['name'][$index][$field];
        $tmp_name = $_FILES[$group]['tmp_name'][$index][$field];

        $ext = pathinfo($file_name, PATHINFO_EXTENSION);
        $new_name = uniqid() . '.' . $ext;

        $upload_dir = DOCROOT . 'uploads/schedule/';
        if (!is_dir($upload_dir)) {
            mkdir($upload_dir, 0777, true);
        }

        move_uploaded_file($tmp_name, $upload_dir . $new_name);

        return 'uploads/schedule/' . $new_name;
    }

    return null;
}
```
