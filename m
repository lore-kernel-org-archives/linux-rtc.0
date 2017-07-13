Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:37454 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdGMSSs (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 13 Jul 2017 14:18:48 -0400
Date: Thu, 13 Jul 2017 20:18:46 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RTC for 4.13
Message-ID: <20170713181846.xdoocvlziyfhrajk@piout.net>
References: <20170713090151.47rrpc62dxcqwvtz@piout.net>
 <20170713092239.r6cndjmnsrb35c34@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170713092239.r6cndjmnsrb35c34@piout.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Me again...

On 13/07/2017 at 11:22:39 +0200, Alexandre Belloni wrote:
> On 13/07/2017 at 11:01:51 +0200, Alexandre Belloni wrote:
> > Hi Linus,
> > 
> > Here is the pull-request for the RTC subsystem for 4.13.
> > 
> 
> And I forgot to add that you will see a small Add/Add merge conflict in
> tools/testing/selftests/timers/Makefile which is easy to solve.
> 

And its not actually add/add but both patches are adding a target on a
different line.

Sorry about the miscommunication, I'll get back to wiping baby poop.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
