-- 최신순, 좋아요순 선택정렬

delimiter //
CREATE PROCEDURE PostSort (
    IN criteria VARCHAR(20)
)
BEGIN
    if criteria = '최신' then
        SELECT *
          FROM post
         ORDER BY created_by;
    
    ELSEIF criteria = '좋아요' then
        SELECT *
          FROM post 
         ORDER BY (SELECT 
                          p.id,
                          p.title,
                          p.content,
                   COALESCE(l.like_count, 0) AS like_count
                     FROM post p
                     LEFT JOIN (
                   SELECT post_id, COUNT(*) AS like_count
                     FROM likes
                    GROUP BY post_id
                     ) l ON p.id = l.post_id;
         )
   
    END if;
END //

delimiter ;