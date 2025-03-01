class FixedList < List
    before_update :prevent_update
    before_destroy :prevent_destruction

    private

    def prevent_update
        errors.add(:base, "Cannot update a fixed list")
        throw(:abort)
    end

    def prevent_destruction
        errors.add(:base, "Cannot delete a fixed list")
        throw(:abort)
    end
end