Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422177;
	b=1lDmHhg4VhpR/wX4zRvwBn6QWB+36m5oq413ztLsUe9f4ZiA/PMHW/9F2qhIwkd35HGp
	 h+ZGQ5tx1smCeMeuLkexEryan3vJljwYFY9xXvRN5QNVWa5ZROl6UF8rWUduQs4KWrGes
	 /GEl6MQuIZo/h+Xf3MQpFCe9g5RW5BrF8bHWqyw7U/P0RPZYlbLWQaWx77XwKc1HJyx8j
	 XUnqm96tfVdKwOu6lO7Ng4QJbTLjKY5EzJrG/mC/RqTyfhGH2NQGifpp93MDnOMIeMZCY
	 rTnp4ydxdY0IsdcTPsw5YhZatvqmbS3NfME32+HxImPsX95HLglb+ZnJ5i7Suuati9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422177;
	h=Received:Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 Date;
	bh=LxZiUgWcdu3JP6X6XWQddMkXVSpfN9RPD7L5defgDRQ=;
	b=GVAywaeBajgZbTHMjEu5bXf8O3JNhO4gq37drp5CXLMFBNLzOXNHC16aT/c8HKEBaq3G
	 R+5WjvObvYYhe+LwqBiAi3F8O6WlJmn4i6kU4LskRtLm9atZarJ5K6LKLlbJI7CZatVzO
	 sE5s5Mi3UciRx8W+i0RTC7JO6K0u3xvmyYDKUX5/Pd7RJ3pSYuqHpVuci7sOKJs8rlWDS
	 Kiy3uFVvIRQgm4jMWRfW1GDsGdfbLCFqk1K7K4DEU2HhV4MUFH7DTSGP/L5IPFXGW6p4y
	 1PmmRO/zn+hNeyjh9y3abZYT2Ul5/qPvTivP5ImNYLZpQI9S/7cIrqp/Vu8tVc0f+TA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1fB+rdd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF64607BF2E
	for <linux-rtc.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1fB+rdd
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F76513E4
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422177; cv=none; b=FVNx5mA6rh6iBZ5IsCenUm4wf72RrVpbE0R6Sxh9G4WmOYgVoT5FYHpFpNBeGhJV1htUQuwCKM/DYTzYu8qh7CL2Ld/sug5MIemUzqxVmjhRKWZ9rDiCPgXICkyvz2o+Z40D/QJkRxYZ0E5rvrcfslKc9FEFilZoOnBIssNPyBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422177; c=relaxed/simple;
	bh=iBcxdhmigHyrY9/HxHB/5hnlohWNQZfXx9LlnUHxIAY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oybnp6AZfsqaHXPAt9AuyHUv/Z+iWOBknvsFpgE+F4wfsPgcCEgBC90qwi1QF6A/LyTNKXqvoVfeMj6UPsEtM7EGeYXzZ8S5bep/KCJegeAN+wvwkn6xh0KuNoMWULSwBrH3Xav9cPYvTQNYowLjBWHw+eY1CUv+hUxTEKNu8wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1fB+rdd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A821F000C5;
	Mon, 19 Oct 2026 15:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422176;
	bh=LxZiUgWcdu3JP6X6XWQddMkXVSpfN9RPD7L5defgDRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R1fB+rddGe7eIqFPtlec6zngYkozlOi1fpWErcWBSwURxv22NmKaxZzbJri/g9wzJ
	 CB+rdMwLD1RwrgnyzgHtYhQLUH5s6g2ZxsOxTdyeQIDyb6SKn1gKOwtJEMRfSxhhVz
	 +MZ3AaNlM4drnr9eLmKG9WBibWaJO+e0TvsxgnZBiAvTkz3OnRhXAl2ZoTRLdDOCah
	 q+9AuCpOa8oSD27PrQnJolRqCv1nlaVuT65CGX46ikbGR/DsloN6+IauJYuiTYQnO7
	 7UOU6fw94n/L2+Y3IVnaXEZAoZYKwPF8ABJKSS1TH45V7bTKk6W9RlaHcxSKbqKQos
	 AOf0n4UfHU93g==
Message-ID: <sashiko-outbox-177596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] rtc: brcmstb-waketimer: add missing
 MODULE_DEVICE_TABLE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261019135441.1420968-370-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-370-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:02:56 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Pengpeng Hou <pengpeng@iscas.ac.cn>
>=20
> [ Upstream commit 402c89d28fecd28652a4bfe997f08f6544836381 ]
>=20
> The driver has an OF match table wired to .of_match_table, but does
> not export the table with MODULE_DEVICE_TABLE().
>=20
> Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> information is generated for OF based module autoloading.
>=20
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the platform driver, and the missing module alias publication.
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> Link: https://patch.msgid.link/20260704121734.54941-1-pengpeng@iscas.ac.cn
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-370-sashal@kernel.org?part=3D1

