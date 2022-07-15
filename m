Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C412C43334
	for <linux-rtc@archiver.kernel.org>; Fri, 15 Jul 2022 13:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiGONfx (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 15 Jul 2022 09:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiGONfx (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 15 Jul 2022 09:35:53 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956897CB7A
        for <linux-rtc@vger.kernel.org>; Fri, 15 Jul 2022 06:35:49 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CD41A20000A;
        Fri, 15 Jul 2022 13:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1657892148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GixBYr/dyhLisknZIt6iN8Pj5jT2bDrSviwZp/FYUOM=;
        b=W3sdltJZZ+sm2NzJRXyujOuKW6LOUsAmEkSwuDI7qIbCFB2TDykVtccIpFHOEmElHmbKPn
        i4JhusAMPqi1E0ZLj9zbgQhPUIu85/1HTiJmku1GLSc1HoZ1grSNkD6/lpuJR/60ULCcrT
        RLIInTtswevtJ5GjDL5ARrYWEGzJ4z1leCcg7yHUvfBRWnVlAjhXTaOBxsnNM6BVaC+pP+
        +gGrG2jzJwsJcFwb/oeP6gKNSYQr6SVenIwh7KREjPbH5CnAUhyxciKzY6S4CVns0BdU4K
        6eEjRQr3lS3dQzSc06E33J4aDODbhHjqy9PBCQQ+epbzSBd/hszAILnwvVO9ww==
Date:   Fri, 15 Jul 2022 15:35:47 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Kevin Rowland <kevin.p.rowland@gmail.com>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: rtc: userspace alarmtimer via posix-timers or timerfd
Message-ID: <YtFtMzpFQPxnEbHw@mail.local>
References: <CAHK3GzwVbWBi8OYOmdnDq7nOxwp45qpSFU4UT+wK0=UVUNyQsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHK3GzwVbWBi8OYOmdnDq7nOxwp45qpSFU4UT+wK0=UVUNyQsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 11/07/2022 17:48:49-0700, Kevin Rowland wrote:
> Hello,
> 
> I'm curious if there's some mechanism in the kernel to bridge POSIX
> timers (or the timerfd subsystem) and the alarmtimer feature.
> The intent is to give userspace the ability to set timers that
> (optionally) result in the system waking from suspend via RTC alarm.
> 
> I was thinking about hacking together something myself in
> `kernel/time/posix-timers.c`, but then found `alarmtimer.c` which, as
> far as I can tell, is exposed only to the rest of the kernel.
> 
> Any pointers welcome.
> 

alarmtimers are POSIX timers, see https://lwn.net/Articles/429925/

Simply use the CLOCK_REALTIME_ALARM clockid

> Best,
> Kevin

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
