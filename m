Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:33967 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdLTRCL (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Dec 2017 12:02:11 -0500
Date: Wed, 20 Dec 2017 18:02:00 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Rabeeh Khoury <rabeeh@solid-run.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Baruch Siach <baruch@tkos.co.il>, linux-rtc@vger.kernel.org,
        "nadavh@marvell.com" <nadavh@marvell.com>
Subject: Re: Armada RTC power up reset
Message-ID: <20171220170200.GA15162@piout.net>
References: <20171130094049.fg3zoxgvhlb7jqw3@tarshish>
 <871skewf05.fsf@free-electrons.com>
 <CA+j0ot=PqFYwN=+zUc5F1uyXQoB9dX1gmwxTbXP-QdzQU+zspQ@mail.gmail.com>
 <20171211160835.GC32306@piout.net>
 <CA+j0otm7EeY034nXj8ESYwSaP3JPuV7OoUS+1+GkQ7eOEAOCuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+j0otm7EeY034nXj8ESYwSaP3JPuV7OoUS+1+GkQ7eOEAOCuw@mail.gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 11/12/2017 at 20:14:00 +0200, Rabeeh Khoury wrote:
> The first; sets the values to a know good state (including time=0) on it's
> probe() -
> https://pastebin.com/ubqwEBBM
> 

No, as explained that would be bad for userspace as it will have now way
to know whether the time is correct or not (you may as well not have any
RTC at all).

> Second return -EPERM on an uninitialized RTC until first write resets it's
> values to a known condition on first write (as Gregory suggest) -
> https://pastebin.com/r7sydF8G
> 

-EINVAL is the proper error code for an uninitialized RTC but yes, that
would be the idea.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
