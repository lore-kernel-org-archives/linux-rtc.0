Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545017;
	b=yDIXvPF9UjRuF52WD757cROJ6IDc0vIXjo8203nI+v/THhQyGdYCWoX9eeIez/EEorQW
	 QX0fd2MI7ZXAYNni3+gh6p5p5vlWYslrv/gVH0Ap/Y85Wlor/f0v2LPYsKe7Cp5nG9imK
	 LBeXzUzYxFu3zDckPLZLEB0yhuoP7Js7eWq4Vdng7FyIngufx4OAqopTuemjuEq6eMAX8
	 Rs2fK7EvA2k9ZyIgP1q8IN9Go76fwHjRZpUKjOIwlMP169Ab185dmwrjngzEYZZdXkY3E
	 b7d2jYIXa29y2fK6zIkDih9cXiXKfZAPipqoMlSEzV8rWitxmk7Aw2ldccaE2gdyKuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545017;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=0K0WZc/39/LoeP518yVuoZSqLaQqIw4BwskJvntaZvY=;
	b=ADeXVdBEy4Csste52w6FkjzfE++WfiyH74stdtqjNT3hvvOwksJDRXQeJId6xP65EGnq
	 P+5g5Gl/K9nwMxqVU2mtdlP8ppDfTeXQo18epjdADabbRu5twxTa0WUotZBILDGTyvuYq
	 QmavS71pLCC22NxAhquMdPfS7ryNCLvQ/7Kfl1ew91gL7Zek1lQtqghH1psPS4LMrCiUP
	 0hRFo1P3ggIJM9MpHgzt8wc4prVlQ5DfXYGXF/RYEKHy3ONHapONviIZceD6hEbWcXJUR
	 GAKw2HwlUPPP0hLRWqaW8QqlDsij4Iz/Z6vbmQbcOEgEqQcAEzjCk28asY/30vD/bJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=U4V8Lmxp;
	arc=none smtp.remote-ip=95.215.58.212
Received: from mta1.migadu.com (out-212.mta1.migadu.com [95.215.58.212])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092C606A32A
	for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 18:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2092C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=U4V8Lmxp
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5FzHrKNgD5lCIK6oHJu6SlDrdrGmdZHkQ/9jYR5U3ZU=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795545014; v=1; x=1796149814;
 b=U4V8LmxpaxCGNshsJQMp1cGqvNoMnmJ61t4agxFJvdLgGE89eKi6YbLla8aOfehsipx5T2n4
 HWgJRpfRw4kEL/JUvalPLYfgURfguVd29h0ePzJ+ABt6PfmU4mVx2A+tklIS53+6qnVmccIFIRH
 lJ9lYUAFK+VXQ+yp0WMIZ92HXIeR8Y6Hq8kbbS300vJs1kOadA1EumZjNH6XL+oXkQApGV+0/yD
 UhsbzpurWw/kKqi/HzhYt676/2jaGpRZAIc3VnbYxSfC0poxbBidkBNK452LjMuoVlceTOC4b69
 ag+p5cpx0e4I1v5YO6l/VHzqWhwltmPMbf4AUuuVCFnRA==
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cf4f11413430c8c2;
	Tue, 24 Nov 2026 18:30:12 +0000
X-Mizu-Trace-ID: cf4f11413430c8c2
X-Migadu-Flow: FLOW_OUT
Message-ID: <87735cc2-3759-4b7b-a16d-8aa4911ea7fb@packett.cool>
Date: Tue, 24 Nov 2026 15:30:04 -0300
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] rtc: Add basic support for RTC via Surface System
 Aggregator Module
To: Emfox Zhou <emfox@debian.org>, Maximilian Luz <luzmaximilian@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <20261104070441.74127-1-val@packett.cool>
 <20261104070441.74127-5-val@packett.cool> <1795439501.1366.emfox@debian.org>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <1795439501.1366.emfox@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/23/26 10:11 AM, Emfox Zhou wrote:
> Hi Val,
>
> Tested on a Surface Pro 8 (x86, Tiger Lake): this is not SPX/ARM-only, the
> same SAM RTC sits behind the aggregator there. Two things came out of it.
Didn't think anyone else would be interested though :) as the SPX is the 
only machine with *no other working RTC at all*.
> First, as posted the driver cannot bind on the x86 machines: 5/5 adds
> ssam_node_rtc only to ssam_node_group_spx[], while the x86 devices come
> from the ACPI-matched groups. With one line in ssam_node_group_sp8[],
>
> 	&ssam_node_rtc,
>
> "ssam:01:01:01:00:00" appears and the driver registers rtc2:
>
> 	surface_rtc 01:01:01:00:00: registered as rtc2
>
> It would be good to have the node in the other x86 groups as well. Note
> that the node name will collide with the SPX one, so whichever lands
> first keeps it.

Well, I don't have all these machines to test on, so I wasn't very 
confident about adding it to other groups. I could do it though, sure.

> Second, set_time() needs a timezone compensation. The EC keeps UTC in the
> SAM timestamp (CID 0x10), but also exposes _GRT (CID 0x1f), the same clock
> plus the zone stored in the EC, and the firmware copies _GRT into rtc_cmos
> at POST. Right after a cold boot here:
>
> 	rtc0 read at boot	 1795199717
> 	true UTC at boot	 1795170940
> 	EC _GRT at boot		 1795199714	(zone +28800)
>
> so CMOS came from _GRT, 8 h ahead of UTC. The write side shows the same:
> after "hwclock -w -f /dev/rtc2" the SAM timestamp equals system UTC and
> _GRT is then UTC + zone, so the next cold boot is off by the zone again.
> Either write (UTC - zone), taking the zone from _GRT minus the timestamp,
> or state that this RTC is local time and leave the conversion to user
> space.
Ack
> Tested-by: Emfox Zhou <emfox@debian.org> # Surface Pro 8 (x86), with ssam_node_rtc added
>
> Since the same RTC is on the x86 machines, the descriptions are no longer
> accurate either: the commit message, the Kconfig help and the MAINTAINERS
> entry all name the Pro X: [..]

Sure, I'll change the names!


Thanks,
~val

