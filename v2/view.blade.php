<?php foreach ($posts as $post): ?>
    <h3><?= $post->title ?> (<?= $post->public_date ?>)</h3>
    <p>Staff: <?= $post->staff_name ?></p>
    <hr>
<?php endforeach ?>

<!-- Pagination -->
<p>Page <?= $page ?> of <?= ceil($total / $per_page) ?></p>
