local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  print("comment is not available")
  return
end

comment.setup()
