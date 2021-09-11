Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27F8C433FE
	for <linux-rtc@archiver.kernel.org>; Sat, 11 Sep 2021 17:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8495961029
	for <linux-rtc@archiver.kernel.org>; Sat, 11 Sep 2021 17:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhIKRbT (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 11 Sep 2021 13:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232635AbhIKRbT (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sat, 11 Sep 2021 13:31:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4E58E60FED;
        Sat, 11 Sep 2021 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631381406;
        bh=k1KRNJGuhUOQwxZ17K8TuiC2Lxquyc/jIHnaqoepqdM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UB1Fyi0bdfOOOFvkAB1639k3rzPaZAyGY0KiB0fAZ/mb92VwPx1YwgOS0Tn3yWSSW
         5xjsUYTZlOK6pEqtBv+7mnwWMHkJx0NIWJSENwT+bbGK/smJggMZNqRhnGJMDpJlFi
         XPkD5CFfxpQ+9Tgs8Lf3mQMl4HFH2sfuC2g8beihFoxvJn2qiAAWKvJeJUGuZ6u9gx
         0ImEroE1BdLBYRWpjUxGZCqo9vTFiRiMFUAmbUB+v5yD3pyspZuvweIKpbJgqHMOz5
         DPdwU/Aqk9lDC3VLINMZD9jbEK5BE+UWArMgGRoToLMnOtp+C2z0feMtAn6tDoqcoD
         8l3WIPnkf86DA==
Subject: Re: [GIT PULL] RTC changes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTzSVk5Scx/nRP7K@piout.net>
References: <YTzSVk5Scx/nRP7K@piout.net>
X-PR-Tracked-List-Id: <linux-rtc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTzSVk5Scx/nRP7K@piout.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.15
X-PR-Tracked-Commit-Id: 0c45d3e24ef3d3d87c5e0077b8f38d1372af7176
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 107ccc45bb25c7fdc7a744496caa4d8a52af4812
Message-Id: <163138140629.31565.15345255369155701465.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Sep 2021 17:30:06 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The pull request you sent on Sat, 11 Sep 2021 17:59:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/107ccc45bb25c7fdc7a744496caa4d8a52af4812

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
