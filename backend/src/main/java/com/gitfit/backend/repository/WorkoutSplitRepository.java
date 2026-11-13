package com.gitfit.backend.repository;

import com.gitfit.backend.entity.WorkoutSplit;
import org.springframework.data.jpa.repository.JpaRepository;

public interface WorkoutSplitRepository extends JpaRepository<WorkoutSplit, Long> {
}
