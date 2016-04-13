def two_sum(nums)
    i=0
    puts nums.length
    while i<nums.length-1
        j=i+1
        while j < nums.length
            if nums[j]+nums[i]==0
                return [i,j]
            end
            j+=1
        end
        i+=1  
    end  
    return nil
end

puts "two_sum[1,3,5,-3]"
puts two_sum([1,3,5,-3]).to_s
