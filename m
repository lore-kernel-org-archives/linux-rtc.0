Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDA4C433EF
	for <linux-rtc@archiver.kernel.org>; Fri,  1 Apr 2022 17:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350373AbiDARmC (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350548AbiDARmA (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 1 Apr 2022 13:42:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05A4CB03A;
        Fri,  1 Apr 2022 10:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE403B8259E;
        Fri,  1 Apr 2022 17:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BE66C2BBE4;
        Fri,  1 Apr 2022 17:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648834808;
        bh=Y/SOrT9DPEuCVmtDpNcpt4Aa8fKNsJJ5vud/LZK2xJQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ANvR1e3vThrizdknLO6cMOCPvMNqThAOt/DnPR1D6BWsWvzEnh8W21MSsvSKUw5Vg
         +FhHFHB8D7DQ1ErNGnvpBE23R4anYpPGYreVtNWEGUPeTmqb9ujZCfp6YUeCxLZLDy
         VeLM9c/W9xj9LLvYcw2p1DsOly3nkS4qWebih/Xk/CYLIpFrVuRMX42CPFn1wOUaj5
         n/LiiTU9kpiI6KjaMgIPgiwAe83RnfeRnatlhd8sWRJXkkGNNjd7L/InCBhn3bHe34
         kLZvcqYnKPsOXtPIC9siZUF+9ZYsvfOP84H8LkyqN2Ys29BNLKStsgmWjnJn/Vnx0Q
         aXx6xXA/POeSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A530EAC09C;
        Fri,  1 Apr 2022 17:40:08 +0000 (UTC)
Subject: Re: [GIT PULL] RTC for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkYpfK5ubwafd+Rw@mail.local>
References: <YkYpfK5ubwafd+Rw@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkYpfK5ubwafd+Rw@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.18
X-PR-Tracked-Commit-Id: 915593a7a663b2ad08b895a5f3ba8b19d89d4ebf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a34fdcca452457a530980be2561dab06da3627f
Message-Id: <164883480854.11835.11175062877767734932.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Apr 2022 17:40:08 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The pull request you sent on Fri, 1 Apr 2022 00:21:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a34fdcca452457a530980be2561dab06da3627f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
