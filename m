Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:45630 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeDRQM1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Apr 2018 12:12:27 -0400
Date: Wed, 18 Apr 2018 19:12:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Rob Herring <robh@kernel.org>
Cc: "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>
Subject: Re: [bug report] rtc: pxa: convert to use shared sa1100 functions
Message-ID: <20180418161218.intsnuj7l2a4b4k3@mwanda>
References: <20180418142308.GA13543@mwanda>
 <CAL_JsqJTstU6wkdXyvfga24oefRasL9MZig_ctdWMK49+55csg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqJTstU6wkdXyvfga24oefRasL9MZig_ctdWMK49+55csg@mail.gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Apr 18, 2018 at 10:58:08AM -0500, Rob Herring wrote:
> On Wed, Apr 18, 2018 at 9:23 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > [ This code is several years old now.  - dan ]
> 
> Did I miss an earlier bug report?
> 

No.  It's a new-ish check and I hadn't reviewed all the non-x86 warnings
yet.  I was just thinking that it's weird to see such an old warning.

regards,
dan carpenter
