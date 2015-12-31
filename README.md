# Simplify fetching data from RestKit context

## Examples
- User.rk_findAll()
- User.rk_findAllSortedBy(sortTerm: "id", ascending: true)
- User.rk_findAllWithPredicate(predicate: predicate)
- User.rk_findByAttribute(attribute: "active", searchValue: true, orderedBy: "id", ascending: true)