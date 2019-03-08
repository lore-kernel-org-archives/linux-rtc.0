Return-Path: <SRS0=BS7E=RL=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFBCC43381
	for <linux-rtc@archiver.kernel.org>; Fri,  8 Mar 2019 18:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4C12085A
	for <linux-rtc@archiver.kernel.org>; Fri,  8 Mar 2019 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552070103;
	bh=4A7yW6xBv/zI3B+TbDiEVypi9qZr8X6wvfmOVKBVSzI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QQKQdiNf1iKgvl3fJgUnNxJ4//BmiB28DY7teu7Lo6U3dB+G88G7YdpPqet3dclGe
	 RLo4euDf2LxjvvCnqluT2bvQLSrA9xHMeoTMvJtJMgsDsHcNRlEBtEOoQpEMFVp6Jz
	 YZqtkY7eKn+wsVp9XrRM0SSnCG1cZc+SuxO6w2a8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfCHSfD (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:35:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfCHSfD (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 8 Mar 2019 13:35:03 -0500
Subject: Re: [GIT PULL] RTC for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552070102;
        bh=4A7yW6xBv/zI3B+TbDiEVypi9qZr8X6wvfmOVKBVSzI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Tdboo0N6LoE+9GzpBLkN188cPxrqWmapm6NlQFa5KsX1pw38QP84W10keyo9j/IIY
         yxQpyTYBqQ6U3Knz7fZBQ5N5xgFkfLzaUHpyUnh1fY4j3jb6cL8Vmlt3IJ8QloMD02
         0RPD9UOfKIPuvl5z24w4t93fgy3fd8JXkLc8sYV8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190306225620.GA17610@piout.net>
References: <20190306225620.GA17610@piout.net>
X-PR-Tracked-List-Id: <linux-rtc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190306225620.GA17610@piout.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.1
X-PR-Tracked-Commit-Id: e91b94fd2bc411b5926031496bbc3de9a96bb1c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8d35403ebf5a6cce6a2347015f465a4da470f7b
Message-Id: <155207010252.7904.7086108383861837646.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 18:35:02 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 23:56:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8d35403ebf5a6cce6a2347015f465a4da470f7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
