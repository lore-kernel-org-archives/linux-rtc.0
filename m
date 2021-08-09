Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75468C4338F
	for <linux-rtc@archiver.kernel.org>; Mon,  9 Aug 2021 22:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2B5601FD
	for <linux-rtc@archiver.kernel.org>; Mon,  9 Aug 2021 22:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbhHIWKX (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:10:23 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44479 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbhHIWKX (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 9 Aug 2021 18:10:23 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id BAD29E0002;
        Mon,  9 Aug 2021 22:10:00 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, Cassio Neri <cassio.neri@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5] rtc: Improve performance of rtc_time64_to_tm(). Add tests.
Date:   Tue, 10 Aug 2021 00:10:00 +0200
Message-Id: <162854698133.238383.3736740084127309703.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210624201343.85441-1-cassio.neri@gmail.com>
References: <20210624201343.85441-1-cassio.neri@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, 24 Jun 2021 21:13:43 +0100, Cassio Neri wrote:
> The current implementation of rtc_time64_to_tm() contains unnecessary
> loops, branches and look-up tables. The new one uses an arithmetic-based
> algorithm appeared in [1] and is approximately 4.3 times faster (YMMV).
> 
> The drawback is that the new code isn't intuitive and contains many 'magic
> numbers' (not unusual for this type of algorithm). However, [1] justifies
> all those numbers and, given this function's history, the code is unlikely
> to need much maintenance, if any at all.
> 
> [...]

Applied, thanks!

[1/1] rtc: Improve performance of rtc_time64_to_tm(). Add tests.
      commit: 1d1bb12a8b1805ddeef9793ebeb920179fb0fa38

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
