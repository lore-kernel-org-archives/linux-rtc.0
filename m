Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5506CC433EF
	for <linux-rtc@archiver.kernel.org>; Sun, 10 Apr 2022 02:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiDJCKF (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 9 Apr 2022 22:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiDJCKE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 9 Apr 2022 22:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCC518D;
        Sat,  9 Apr 2022 19:07:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 260F460E73;
        Sun, 10 Apr 2022 02:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65019C385A5;
        Sun, 10 Apr 2022 02:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649556474;
        bh=+q7eq4tkkz6wGol2/JZxVyHuQyxO/HeZbkbaq1RKBWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JsxKEVQq9MXEsljnZggogU/8WLetd2wdmiCN2t0YfniuWLcRYu30gQ/y+V6XHkA14
         d3ANy5XruGXuWNh1yE36nMkK9IUNLmpQso0BpcbSg1FlCK6er2gsivXZON5JcMGJs/
         Q0SYVhWQPYzp2l740qo4j2DTfp0B8gwQtIodFOo59+IkKr83eQHwSGEMPYMSJhQxex
         SqPR0hmgwiH8LsVUUiSOM7z/T7d/B+dU6wxd5f9nFT6u56m9A3N3eYhePTo9QYYXcu
         6glLcViBZM8W18KaO6z0YN4Memmx8gSoBkgk4xfIX0O2oR+Mq/ifWYpxSXQLyfW4xb
         trwCQsfnj7n2Q==
Date:   Sat, 9 Apr 2022 22:07:53 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH for STABLE] rtc: mc146818-lib: fix RTC presence check
Message-ID: <YlI7+ZrdiAIGYwFU@sashalap>
References: <20220408212337.5713-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220408212337.5713-1-mat.jonczyk@o2.pl>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Fri, Apr 08, 2022 at 11:23:37PM +0200, Mateusz Jończyk wrote:
>commit ea6fa4961aab8f90a8aa03575a98b4bda368d4b6 upstream.
>
>Please apply to 5.15 and 5.16 trees.

Instead of the backport, I took two dependencies and queued it for 5.16
and 5.15. Thanks for reporting!

-- 
Thanks,
Sasha
