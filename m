Return-Path: <SRS0=a9T5=D4=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28808C4363A
	for <linux-rtc@archiver.kernel.org>; Wed, 21 Oct 2020 18:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6CBD21531
	for <linux-rtc@archiver.kernel.org>; Wed, 21 Oct 2020 18:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603305309;
	bh=E5IsMeaMoFuZe+PiVfyYvZi0W2Lbd8VHhUJ5bgGjx1k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Dkf1HrKE6EEejpkT0Gavwr3mhMPR61HKz6AFT/a/EsiNFuJjs5ls+/zkEJjhvtfVh
	 h46OF6I9lMK9CBvXTDRqNC1d6DpDETLtTRdyisgki9zM+jaKpiXYNeujUQMeUMkHcx
	 3M0ikruMT1qaKTHfrStsFuOaSjEIrsaiSNme33AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439031AbgJUSfJ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392431AbgJUSfJ (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 21 Oct 2020 14:35:09 -0400
Subject: Re: [GIT PULL] RTC for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603305308;
        bh=E5IsMeaMoFuZe+PiVfyYvZi0W2Lbd8VHhUJ5bgGjx1k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yj4F9BziNMnxIw4Ifx0nnh/jIWyXK/VKdR5OCsMms+Z9tCGwqOKsje5XCeJvAk9q+
         gDSiWWGFKmqBFulBnQnPNlE+vddillwdm6bOZMsK7G/wJ89qIrrGZkBFpkQBK9ucPz
         PRko1lLmnBE3QgeUffEdD9l10p+ky0Yo85kfyx7M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201021082320.GA1457765@piout.net>
References: <20201021082320.GA1457765@piout.net>
X-PR-Tracked-List-Id: <linux-rtc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201021082320.GA1457765@piout.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.10
X-PR-Tracked-Commit-Id: 35331b506f6c67a0b4042fac1ae2785cef9ac8c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7769c45b8d95f1c70b9dec38c8de8ad229ce222
Message-Id: <160330530875.16606.6752108185683007620.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Oct 2020 18:35:08 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The pull request you sent on Wed, 21 Oct 2020 10:23:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7769c45b8d95f1c70b9dec38c8de8ad229ce222

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
