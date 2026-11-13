package com.gitfit.backend.repository;

import com.gitfit.backend.entity.ChallengeEntry;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ChallengeEntryRepository extends JpaRepository<ChallengeEntry, Long> {
}
