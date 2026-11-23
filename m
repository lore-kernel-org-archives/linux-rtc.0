Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439543;
	b=ApTARoiq/Iu8Lu8dvcMKzls2jyQ0MaFdxLkFxb4trex4Zbc8njhZYlCp80RMXt7OIFfj
	 iQfuGK5/9gEAQ9W/GqbvmqD92aQGo+/5D+uTQJbd0kfA7/KmwEtDoGSW3MIwqAZ4yoB/I
	 75sWwqY+z/hEre+Xz6yzHzC7Mf+b8WZehF2QpSn5aiwXmwSy1dpJMRbIupVyrJz3l0FQq
	 aOY7DLIn1t6wtB8FJ+sbDG8v0ucqxDtwDDmS9s8DffnS2eVAUvHH8rErAGdX2da+R+8aH
	 HAV/d5IVFp3gyfZ3bn59pZc9BOJUT2eENlzeiJQTWfOqlaVOXIqWLjik3lUmHlaxLGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439543;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:In-Reply-To:
	 References:Cc:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=TmaObXNTB9Nm1xeyOiO53F3dRQ8voxhovl1BhKueyTA=;
	b=OtN8I6arrWFxJoOcgYDYE5nfHi2nAXgX9aznOUo0TPDO6MLMzVY20aNG9BGpLwdVdgPn
	 tzE9od5Lst2mlrn+S1vJ1h/HYKPgkBzZDD/wKQ8Z8boKnDzmsqxYTw7GJXruGtW3a08Da
	 lWMQIu1Ba4PFgTRWcm9w2wyDpQ2jvo+PTe5G9ha10bcjNhA7v5IksRYGxrR5499C9yV6p
	 gHeCCte5YjP/dV6sV33MAirihNDnrBaV4eg57A7SPFO2PqbRAjuVjidYVyUGtRXKqmMgv
	 GFzjP6abs69aVznoShduu4zaMMVrUyEA2XR4NveYtxXPpGM9Vs0FCGY2nPVyBzM7uDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=evwWV+kr;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B46606A31E;
	Mon, 23 Nov 2026 13:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5B46606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=evwWV+kr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:Date:Cc:References:In-Reply-To:Subject:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=TmaObXNTB9Nm1xeyOiO53F3dRQ8voxhovl1BhKueyTA=; b=evwWV+krLearu1MVioYkduo2aF
	l8K5X0zoRQqAYgW4a87na+kAGNDVMqKZXT6o3Hi00+9afcCRHUfnJ0jwk5cBkH0Hn88xPDVzy0xHF
	Ju23NnObI/w5UHNp8BmM722XmC04l69uBKbEam7w/TR1QtqfpK2SvkIUpnYdlstzdZmmAMdiFFZYa
	/1WdLSO2nhMe+Ubn5NnL5F+3arZxR0dZ65QEzXg0Lcy7opVZwR0VPwFRa+vvOlDsS5jpho//QTs6D
	RiBMXKzB0jvKfR067sT6XcL22dFUm+X/1OHwadr3Rv4KK7KanEV/8hSbWP4tlmpgU+Jml0GdlcJXo
	Ghu1+BFw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xVTpv-005EKr-05;
	Mon, 23 Nov 2026 13:11:59 +0000
From: Emfox Zhou <emfox@debian.org>
To: Val Packett <val@packett.cool>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 4/5] rtc: Add basic support for RTC via Surface System Aggregator Module
In-Reply-To: <20261104070441.74127-5-val@packett.cool>
References: <20261104070441.74127-1-val@packett.cool> <20261104070441.74127-5-val@packett.cool>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rtc@vger.kernel.org
Date: Mon, 23 Nov 2026 21:11:41 +0800
Message-ID: <1795439501.1366.emfox@debian.org>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Debian-User: emfox

Hi Val,

Tested on a Surface Pro 8 (x86, Tiger Lake): this is not SPX/ARM-only, the
same SAM RTC sits behind the aggregator there. Two things came out of it.

First, as posted the driver cannot bind on the x86 machines: 5/5 adds
ssam_node_rtc only to ssam_node_group_spx[], while the x86 devices come
from the ACPI-matched groups. With one line in ssam_node_group_sp8[],

	&ssam_node_rtc,

"ssam:01:01:01:00:00" appears and the driver registers rtc2:

	surface_rtc 01:01:01:00:00: registered as rtc2

It would be good to have the node in the other x86 groups as well. Note
that the node name will collide with the SPX one, so whichever lands
first keeps it.

Second, set_time() needs a timezone compensation. The EC keeps UTC in the
SAM timestamp (CID 0x10), but also exposes _GRT (CID 0x1f), the same clock
plus the zone stored in the EC, and the firmware copies _GRT into rtc_cmos
at POST. Right after a cold boot here:

	rtc0 read at boot	 1795199717
	true UTC at boot	 1795170940
	EC _GRT at boot		 1795199714	(zone +28800)

so CMOS came from _GRT, 8 h ahead of UTC. The write side shows the same:
after "hwclock -w -f /dev/rtc2" the SAM timestamp equals system UTC and
_GRT is then UTC + zone, so the next cold boot is off by the zone again.
Either write (UTC - zone), taking the zone from _GRT minus the timestamp,
or state that this RTC is local time and leave the conversion to user
space.

Tested-by: Emfox Zhou <emfox@debian.org> # Surface Pro 8 (x86), with ssam_node_rtc added

Since the same RTC is on the x86 machines, the descriptions are no longer
accurate either: the commit message, the Kconfig help and the MAINTAINERS
entry all name the Pro X:

> +	  Say yes here if you want to support the RTC functionality of the
> +	  Surface Aggregator Module (embedded controller) found in the
> +	  Microsoft Surface Pro X tablet.

> +MICROSOFT SURFACE PRO X RTC DRIVER

Something like "found in Microsoft Surface devices with the Surface
Aggregator Module" for the Kconfig text, and "MICROSOFT SURFACE
AGGREGATOR RTC DRIVER" for the MAINTAINERS entry, would cover the ARM64
Pro X and the x86 machines both. The file header already says
"7th-generation Microsoft Surface devices", so this would make the three
consistent.

Thanks,
Emfox
