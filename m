Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281317;
	b=zbPAZRD0mmrIJlvEwp19r2Qs1L/Aheg8kGNxnrLP8xYwg8OB8nH5HSSZkt2d4Go6c3qc
	 Ru0EKkG0yxM0oyvt47Zhhi/5+NbASbkQfA38HCb6x30TaDvBe+LUPhSgU89XwXNwX3gzt
	 GnJfnkY8Dz7uKNUNlW6SqwMtlRnUXBZFrVfqzfX7xp4eF0GHTAYcKTECg+zntvyRfPkWV
	 hG/EMpdzPkKZyC4nFxYIG3OvvS+e3drAXGmDuVXqfoHZIuMMK6UCPCKHcc5NFN9XboJRK
	 9mk5oVLOPI64/PmGvurlTl+Yk41LvAQSoGYgKFl19ei/TC3qXFN5CA/7F7a7Bl5cHRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281317;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=69kSjZkjgZidm/rjkp31veE8B+F4B7x220CiuCZMsPs=;
	b=qZUB89yiefzCnuN2+gPrx/n1/Y1aeG7YyChUA3aE8NksGx3KhkYTAInQjLOG9ywdNjXK
	 j0jO4hpUa8rcKC9+jet1KiY5+8658Cce4SebjYzjml/iQGJ1fTKk0cb9VoyFo2ZoV1qm1
	 g93KOtMFgl4CVT4i7RvHkBXLtLfF2o/NGxMHNqwsJviYjbZIUr2vFjJ0fyhwBXgaqgaNK
	 mw7247dIGTOqSGzaIpNOZ31Db2MCXdBMot986E8yQgR40bCGcMQKDTniWtefdT/btfHzJ
	 itQxS4aJ1Meq5BFLkx5pLHWte6U6ItyQ4jH9eLmbL+bTynAopcjzmo2rdiAAWWtxBYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJP5gH5T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14460A260F
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJP5gH5T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923C41F031E1;
	Thu, 29 Oct 2026 13:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281316;
	bh=69kSjZkjgZidm/rjkp31veE8B+F4B7x220CiuCZMsPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dJP5gH5T3MGuHqy1ji9LcHG5CRA9vsNQupoeBrryHmndV13fnPfhc2TPKExOLavp9
	 iNvEYBtsqColB2kiW6kTtIQoVkAmjzAO9jxvDGvXkyxO5YG3mMXVNZYef6n9BziXbS
	 tfS5+9BBWZLXMjlt8rHN3p14RyT3vEwC2TO6S6ofoR4iJzq6ASDznMLman83bTnztc
	 6aR5QETjfLQMNyGb3tjBGybxhWwHCnMivysMcuXqEGOxuJ37UqGV73LCG4n7gHwLDN
	 R7UsqZkBKSAjB6AGkSJzT5Umeq3FIwyLO8EP8eGmaHMKEczzeNfbWDGZCY37sc7lA2
	 DToQt6JQnKF7w==
Message-ID: <sashiko-outbox-189414@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] rtc: rx8025: use sysfs_emit() instead of
 sprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261029132339.925021-7-alexandre.belloni@bootlin.com>
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
 <20261029132339.925021-7-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:41:56 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Use sysfs_emit() instead of sprintf() in the sysfs show callback
> (rx8025_sysfs_show_clock_adjust) to conform to the recommended sysfs
> attribute formatting guidelines in Documentation/filesystems/sysfs.rst.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029132339.9250=
21-1-alexandre.belloni@bootlin.com?part=3D7

