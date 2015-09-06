module MustacheTemplateCache
  extend self
  
  def fetch(key, raw_template)
    cache[key] ||= Mustache::Template.new(raw_template)
  end

  def cache
    Thread.current[:mustache_template_cache] ||= LruRedux::Cache.new(1000)
  end

  def clear
    Thread.current[:mustache_template_cache] = nil
  end
end
