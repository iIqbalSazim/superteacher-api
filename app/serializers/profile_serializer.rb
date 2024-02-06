class ProfileSerializer < Panko::Serializer
    attributes :id, :created_at, :role_specific_attributes

    def attributes
        attributes = super
        attributes.merge!(role_specific_attributes)
    end

    def role_specific_attributes
        if object.user.student?
            { education: object.education, address: object.address }
        elsif object.user.teacher?
            { highest_education_level: object.highest_education_level, major_subject: object.major_subject, subjects_to_teach: object.subjects_to_teach }
        else
            {}
        end
    end
end