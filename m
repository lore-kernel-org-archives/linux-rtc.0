Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7C1C7EE2F
	for <linux-rtc@archiver.kernel.org>; Fri,  3 Mar 2023 18:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjCCSpf (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 3 Mar 2023 13:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjCCSpc (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 3 Mar 2023 13:45:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C13A5ADEC;
        Fri,  3 Mar 2023 10:45:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBE3AB819B5;
        Fri,  3 Mar 2023 18:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 865D6C433EF;
        Fri,  3 Mar 2023 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677869070;
        bh=uB24VT8QmRIhz2FWHluKTNPvoq3OEigd1vrKy6Gg7+Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=czsoNUCwEzduGzHE7zbcpAaD53r5Y/UXFDM+/qIZBx+fLct0Eovklt4OQv3i6JyhI
         Enk75TrRH3j2KzP7VY2F0Cden2b0/mZ3IYsuxRZNetaIRIeyOsqbSkvdm0Jb6lRBMT
         P49ll5IinFbf4VaOoGDHuNpMYwJbkN2vAN/YPizZqWiwFeynMIZTUIF4iHnItr+2EM
         kXMV2Xznz3ofdvXPEXSDcdPnhelHobDynfo6BS9SnHVmuNpedi8tITMmpKdsEq4ulP
         Xd8bripD5StwHBT2KxBZqD9uLEwdyQMCWoBpuaL0GslcNk6ZBbQMcwr1fxDqaEoT2J
         e1AEUMBEUuMvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75572C41679;
        Fri,  3 Mar 2023 18:44:30 +0000 (UTC)
Subject: Re: [GIT PULL] RTC for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2023030300024180930d7a@mail.local>
References: <2023030300024180930d7a@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2023030300024180930d7a@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.3
X-PR-Tracked-Commit-Id: 3ca04951b004fa184ff84369448a37bf5df98a79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 271d89394e33aae5391fd886c046ce54c8240e5b
Message-Id: <167786907047.30023.4012839670328384187.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Mar 2023 18:44:30 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The pull request you sent on Fri, 3 Mar 2023 01:02:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/271d89394e33aae5391fd886c046ce54c8240e5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
